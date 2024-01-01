import FungibleToken from 0x05
import MubaToken from 0x05

pub fun main(account: Address) {

    let publicVault: &MubaToken.Vault{FungibleToken.Balance, FungibleToken.Receiver, MubaToken.CollectionPublic}? =
        getAccount(account).getCapability(/public/Vault)
            .borrow<&MubaToken.Vault{FungibleToken.Balance, FungibleToken.Receiver, MubaToken.CollectionPublic}>()

    if (publicVault == nil) {
        let newVault <- MubaToken.createEmptyVault()
        getAuthAccount(account).save(<-newVault, to: /storage/VaultStorage)
        getAuthAccount(account).link<&MubaToken.Vault{FungibleToken.Balance, FungibleToken.Receiver, MubaToken.CollectionPublic}>(
            /public/Vault,
            target: /storage/VaultStorage
        )
        log("Vault setup completed")
        
        // Retrieve the newly created vault's balance and log it
        let retrievedVault: &MubaToken.Vault{FungibleToken.Balance}? =
            getAccount(account).getCapability(/public/Vault)
                .borrow<&MubaToken.Vault{FungibleToken.Balance}>()
        log("Vault Balance: \(retrievedVault?.balance ?? 0.0)")
    } else {
        log("Vault setup completed")
        
        let checkVault: &MubaToken.Vault{FungibleToken.Balance, FungibleToken.Receiver, MubaToken.CollectionPublic} =
            getAccount(account).getCapability(/public/Vault)
                .borrow<&MubaToken.Vault{FungibleToken.Balance, FungibleToken.Receiver, MubaToken.CollectionPublic}>()
                ?? panic("Vault capability not found")

        if MubaToken.vaults.contains(checkVault.uuid) {
           
           log("Vault Balance: \(publicVault?.balance ?? 0.0)")
         

            log("MubaToken vault")
        } else {
           
            log("Not MubaToken vault")
        }
    }
}
