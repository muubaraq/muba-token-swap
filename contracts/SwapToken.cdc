import FungibleToken from 0x05
import FlowToken from 0x05
import MubaToken from 0x05

pub contract SwapToken {

    
    pub var lastSwap: UFix64
    
    pub var userLastSwap: {Address: UFix64}

    pub fun swapTokens(owner: AuthAccount, swapAmount: UFix64) {

     
        let MubaTokenVault = owner.borrow<&MubaToken.Vault>(from: /storage/VaultStorage)
            ?? panic("Could not borrow MubaToken Vault from owner")

        let flowVault = owner.borrow<&FlowToken.Vault>(from: /storage/FlowVault)
            ?? panic("Could not borrow FlowToken Vault from owner")  

      
        let minterRef = owner.getCapability<&MubaToken.Minter>(/public/Minter).borrow()
            ?? panic("Could not borrow reference to MubaToken Minter")

        let autherVault = owner.getCapability<&FlowToken.Vault{FungibleToken.Balance, FungibleToken.Receiver, FungibleToken.Provider}>(/public/FlowVault).borrow()
            ?? panic("Could not borrow reference to FlowToken Vault")  


        let withdrawnAmount <- flowVault.withdraw(amount: swapAmount)
        autherVault.deposit(from: <-withdrawnAmount)
        

        let userAddress = owner.address
        self.lastSwap = self.userLastSwap[userAddress] ?? 1.0
        let currentTime = getCurrentBlock().timestamp

       
        let timeSinceLastSwap = currentTime - self.lastSwap
        let mintedAmount = 2.0 * UFix64(timeSinceLastSwap)

   
        let newMubaTokenVault <- minterRef.mintToken(amount: mintedAmount)
        MubaTokenVault.deposit(from: <-newMubaTokenVault)

     
        self.userLastSwap[userAddress] = timeSinceLastSwap
    }

    // Initialize the contract
    init() {
        // Set default values for last swap timestamp
        self.lastSwap = 1.0
        self.userLastSwap = {0x01: 1.0}
    }
}