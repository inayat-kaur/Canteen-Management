function formatDate(date) {
    // Format the date in the desired format
    return `${date.getMonth() + 1}/${date.getDate()}/${date.getFullYear()}`;
  }
  
  function generateId() {
    // Generate a unique ID (e.g., a UUID)
    return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
      var r = Math.random() * 16 | 0, v = c == 'x' ? r : (r & 0x3 | 0x8);
      return v.toString(16);
    });
  }
  
  function validateEmail(email) {
    // Validate that the email is in a valid format
    const emailRegex = /\S+@\S+\.\S+/;
    return emailRegex.test(email);
  }
  
  module.exports = {
    formatDate,
    generateId,
    validateEmail
  };
  