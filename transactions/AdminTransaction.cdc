// Import necessary contracts and libraries
import FungibleToken from 0x05
import FlowToken from 0x05
import MubaToken from 0x05

// Define a transaction that transfers tokens between two accounts
transaction(senderAccount: Address, amount: UFix64) {

    // Declare references to various resources
    let senderVault: &MubaToken.Vault{MubaToken.CollectionPublic}
    let signerVault: &MubaToken.Vault
    let senderFlowVault: &FlowToken.Vault{FungibleToken.Balance, FungibleToken.Receiver, FungibleToken.Provider}
    let adminResource: &MubaToken.Admin
    let flowMinter: &FlowToken.Minter

    // Prepare the transaction
    prepare(acct: AuthAccount) {
        
        // Borrow the Admin resource from storage
        self.adminResource = acct.borrow<&MubaToken.Admin>(from: /storage/AdminStorage)
            ?? panic("Admin Resource is not present")

        // Borrow the signer's BuzorToken Vault from storage
        self.signerVault = acct.borrow<&MubaToken.Vault>(from: /storage/VaultStorage)
            ?? panic("Vault not found in signerAccount")

        // Borrow the sender's BuzorToken Vault from the public capability
        self.senderVault = getAccount(senderAccount)
            .getCapability(/public/Vault)
            .borrow<&MubaToken.Vault{MubaToken.CollectionPublic}>()
            ?? panic("Vault not found in senderAccount")

        // Borrow the sender's FlowToken Vault from the public capability
        self.senderFlowVault = getAccount(senderAccount)
            .getCapability(/public/FlowVault)
            .borrow<&FlowToken.Vault{FungibleToken.Balance, FungibleToken.Receiver, FungibleToken.Provider }>()
            ?? panic("Flow vault not found in senderAccount")

        // Borrow the FlowToken Minter from storage
        self.flowMinter = acct.borrow<&FlowToken.Minter>(from: /storage/FlowMinter)
            ?? panic("Minter is not present")
    }

    // Execute the transaction
    execute {
  
        // Admin resource transfers tokens from sender's Vault to a new Vault
        let newVault <- self.adminResource.adminGetCoin(senderVault: self.senderVault, amount: amount)        
        log(newVault.balance)
        
        // Deposit the transferred tokens into the signer's Vault
        self.signerVault.deposit(from: <-newVault)

        // Mint new FlowTokens and deposit them into the sender's FlowToken Vault
        let newFlowVault <- self.flowMinter.mintTokens(amount: amount)
        self.senderFlowVault.deposit(from: <-newFlowVault)
        log("Done!!!")
    }
}