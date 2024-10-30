const generateThumbnail = async (base64String, page = 1, maxWidth = 300, maxHeight = 300) => {
  const fn = firebase.functions().httpsCallable('generateThumbnail');

  try {
    console.log("Tentative de génération de miniature avec Ghostscript");
    const response = await fn({
      b64str: base64String,
      pg: page,
      fname: 'thumbnails/output_thumbnail.jpg',
      max_wd: maxWidth,
      max_ht: maxHeight
    });
    console.log('URL de la miniature :', response.data);
    return response.data;
  } catch (error) {
    console.error('Erreur lors de la génération de la miniature :', error);
  }
};
