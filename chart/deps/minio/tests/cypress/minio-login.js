describe('Minio Login', function() {
  it('Check Minio Login', function() {
      cy.visit(Cypress.env('url'), { timeout: 10000 })
      // Fill the username
        cy.get('[id*="accessKey"]').eq(1)
        .type(Cypress.env('accesskey'))
        .should('have.value', Cypress.env('accesskey'));

      // Fill the password
      cy.get('[id*="secretKey"]').eq(1)
        .type(Cypress.env('secretkey'))
        .should('have.value', Cypress.env('secretkey'));

      // Locate and submit the form
      cy.get('form').submit();

      // Verify the app redirected you to the homepage
      cy.location('pathname', { timeout: 10000 }).should('eq', '/dashboard');
      
      // Verify the page title is "Home"
      cy.title().should('eq', 'MinIO Console');
    
  })
})
