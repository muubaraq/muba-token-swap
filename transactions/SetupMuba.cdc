import FungibleToken from 0x05
import MubaToken from 0x05

transaction() {

    // Define references
    let userVault: &MubaToken.Vault{FungibleToken.Balance, FungibleToken.Provider, FungibleToken.Receiver, MubaToken.CollectionPublic}?
    let account: AuthAccount

    prepare(acct: AuthAccount) {

      
        self.userVault = acct.getCapability(/public/Vault)
            .borrow<&MubaToken.Vault{FungibleToken.Balance, FungibleToken.Provider, FungibleToken.Receiver, MubaToken.CollectionPublic}>()

        self.account = acct
    }

    execute {
        if self.userVault == nil {
          
            let emptyVault <- MubaToken.createEmptyVault()
            self.account.save(<-emptyVault, to: /storage/VaultStorage)
            self.account.link<&MubaToken.Vault{FungibleToken.Balance, FungibleToken.Provider, FungibleToken.Receiver, MubaToken.CollectionPublic}>(/public/Vault, target: /storage/VaultStorage)
            log("Empty vault created")
        } else {
            log("Vault already exist")
        }
    }
}