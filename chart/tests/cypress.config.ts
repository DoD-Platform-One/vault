import { defineConfig } from "cypress";

export default defineConfig({
  e2e: {
    env: {
      url: "https://vault.bigbang.dev"
    },
    supportFile: false,
    setupNodeEvents(on, config) {
      // implement node event listeners here
    },
  },
});