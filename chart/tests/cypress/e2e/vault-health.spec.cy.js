Cypress.on('uncaught:exception', (err, runnable) => {
  // returning false here prevents Cypress from failing the test
  // vault throws this error in the console which by default fails the cypress test
  return false
})

describe('Verify vault ui accessibility and components', () => {
  it('Access Vault', () => {
    // Browse to https://vault.bigbang.dev/
    cy.visit(Cypress.env('vault_url'))
    cy.viewport(1520, 1380)
    // Login with token
    cy.get('[data-test-select="auth-method"]').select('token')
    cy.get('input[name="token"]').type(Cypress.env('token'))
    cy.get('button[id="auth-submit"]').click()
    cy.wait(8500); // wait for warning to disappear
    cy.get('h1:contains("Secrets Engines")')
    // Generate random base64 value
    cy.get('a[href*="/ui/vault/tools/wrap"]').click()
    cy.get('a[href*="/ui/vault/tools/random"]').click()
    cy.wait(2000)
    cy.get('h1:contains("Random bytes")')
    cy.contains('Generate').click()
    cy.contains('Copy').click()
    cy.contains('Back to main navigation').click()
    cy.contains('cubbyhole').click()
    cy.contains('Create secret').click()
    cy.contains('cubbyhole').click()
    // Check for policies
    cy.get('a[href*="/ui/vault/policies/acl"]').click()
    cy.contains('prometheus-metrics')
  });
});