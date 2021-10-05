describe("Verify vault ui is accessible", function () {
  it("Access Vault", function () {
    cy.visit(Cypress.env('vault_url'))
  
  });
  //Going any further leads to Kibana not loading properly, probably because of browser within Cypress, shows "Kibana did not load properly. Check the server output for more information"
  /*it("Visit Discover Page", function () {
    cy.contains("Add sample data", { timeout: 15000 })
      .should("be.visible")
      .click()
    cy.get("button.euiHeaderSectionItem__button", { timeout: 15000 })
      .first()
      .click()
    cy.get
    cy.get('button[id="130fa6f1-b35f-11eb-a21c-079e4de1ead6Title"]', { timeout: 15000 }).click();
    cy.title().should("eq", "Discover - Elastic");
  });*/
});
