import { Employee, Notification } from "../types";

// Usługa AI została wyłączona.
export const geminiService = {
  generateDailyBriefing: async (employee: Employee, notifications: Notification[]): Promise<string> => {
    return ""; // Funkcja zwraca pusty ciąg, nie jest już używana.
  }
};