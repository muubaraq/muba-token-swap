import FungibleToken from 0x05
import MubaToken from 0x05

transaction(receiverAccount: Address, amount: UFix64) {

    let signerVault: &MubaToken.Vault
    let receiverVault: &MubaToken.Vault{FungibleToken.Receiver}

    prepare(acct: AuthAccount) {
        // Borrow references and handle errors
        self.signerVault = acct.borrow<&MubaToken.Vault>(from: /storage/VaultStorage)
            ?? panic("Vault not found in senderAccount")

        self.receiverVault = getAccount(receiverAccount)
            .getCapability(/public/Vault)
            .borrow<&MubaToken.Vault{FungibleToken.Receiver}>()
            ?? panic("Vault not found in receiverAccount")
    }

    execute {
      
        self.receiverVault.deposit(from: <-self.signerVault.withdraw(amount: amount))
        log("Tokens transferred")
    }
}