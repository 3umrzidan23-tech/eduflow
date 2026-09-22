const {onCall, HttpsError} = require("firebase-functions/v2/https");
const {setGlobalOptions} = require("firebase-functions/v2");
const logger = require("firebase-functions/logger");
const {GoogleGenAI} = require("@google/genai");

setGlobalOptions({maxInstances: 10});

const ai = new GoogleGenAI({});

exports.chatWithGemini = onCall(async (request) => {
  try {
    const {prompt} = request.data;

    if (!prompt) {
      throw new HttpsError(
          "invalid-argument",
          "The function must be called with a 'prompt' argument.",
      );
    }

    if (!process.env.GEMINI_API_KEY) {
      logger.error("GEMINI_API_KEY is not set.");
      throw new HttpsError(
          "failed-precondition",
          "AI Assistant is not configured properly.",
      );
    }

    const response = await ai.models.generateContent({
      model: "gemini-2.5-flash",
      contents: prompt,
    });

    return {response: response.text};
  } catch (error) {
    logger.error("Error calling Gemini API:", error);
    throw new HttpsError("internal", "Unable to generate response from AI.");
  }
});
