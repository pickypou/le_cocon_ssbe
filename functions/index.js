const admin = require("firebase-admin");
const functions = require("firebase-functions");
const fs = require("fs");
const os = require("os");
const path = require("path");
const write = require("fs-writefile-promise");
const spawn = require("child-process-promise").spawn;
const mkdirp = require("mkdirp-promise");
const gs = require("gs");

const gsExecPath = path.join(__dirname, "ghostscript/Ghostscript.snap");

try {
  admin.initializeApp(functions.config().firebase);
} catch (e) {
  // Ignorer l'erreur si l'initialisation a déjà été faite
}
/* Fonction qui prend un PDF encodé en base64 et génère une miniature */
exports.generateThumbnailFromPDF = functions
    .https
    .onCall(async (
        data, context) => {
      if (!data.b64str) {
        throw new Error("Base64 string of PDF is missing!");
      }

      const b64pdf = data.b64str.split(";base64,").pop();
      const pg = typeof data.pg === "number" ? data.pg : 1;
      const maxWd = typeof data.max_wd === "number" ? data.max_wd : 200;
      const maxHt = typeof data.max_ht === "number" ? data.max_ht : 200;
      const stFname = typeof data
          .fname === "string" ? data.fname : "thumbnail.jpg";

      const bucket = admin.storage().bucket();
      const tmpDir = os.tmpdir();
      const tmpPdf = path.join(tmpDir, "temp.pdf");
      const tmpPng = path.join(tmpDir, "temp.png");
      const tmpThumb = path.join(tmpDir, stFname);

      try {
        await mkdirp(tmpDir);
        await write(tmpPdf, b64pdf, {encoding: "base64"});

        // Utilise Ghostscript pour transformer la page en image PNG
        await new Promise((resolve, reject) => {
          gs()
              .batch()
              .nopause()
              .option(`-dFirstPage=${pg}`)
              .option(`-dLastPage=${pg}`)
              .executablePath(gsExecPath)
              .device("png16m")
              .output(tmpPng)
              .input(tmpPdf)
              .exec((err) => (err ? reject(err) : resolve()));
        });

        // Redimensionne l'image générée en miniature avec ImageMagick
        const args = [tmpPng, "-thumbnail", `${maxWd}x${maxHt}>`, tmpThumb];
        await spawn("convert", args, {capture: ["stdout", "stderr"]});

        // Télécharge la miniature sur Firebase Storage
        await bucket.upload(tmpThumb, {destination: stFname});

        // Générez une URL pour accéder à la miniature
        const [url] = await bucket.file(stFname).getSignedUrl({
          action: "read",
          expires: "03-01-2500",
        });

        // Nettoyage des fichiers temporaires
        fs.unlinkSync(tmpPdf);
        fs.unlinkSync(tmpPng);
        fs.unlinkSync(tmpThumb);

        return {url};
      } catch (error) {
        console.error("Erreur dans le traitement de la miniature:", error);
        throw new functions.https.HttpsError(
            "internal", "Erreur lors de la génération de la miniature.",
        );
      }
    });
