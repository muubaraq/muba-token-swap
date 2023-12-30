
# Fungible Token Project

This is a Flow blockchain initiative dedicated to deploying a tailored Fungible Token contract alongside diverse transactions and scripts designed for efficient token management and interactions. The project is organized into distinct sections, each focusing on particular facets of token management and interactions.

## Part 1: The FlowToken Contract

### Overview

The pivotal component of this initiative is the `FlowToken` contract, which provides fundamental features for the effective administration of fungible tokens. Key functionalities encompass:

-   **Minting Control:** Empowering the contract owner with the ability to mint new tokens.
-   **Vault Resource:** Storage of balances is facilitated through the designated `Vault` resource.
-   **Token Management:** Diverse transactions and scripts have been developed to facilitate comprehensive token management.

### Code Walk-Through

A distinctive highlight is the `deposit` function embedded in the `Vault` resource. This function ensures the secure transfer of tokens while mitigating the risk of double counting. By zeroing out the incoming vault's balance before its destruction, a seamless transition is guaranteed.

## Part 2: Transactions and Scripts

### Transactions

1.  **MINT:** Generate tokens and allocate them to a specified recipient.
2.  **SETUP:** Configure a vault within a user's account storage effectively.
3.  **TRANSFER:** Empower users to transfer tokens seamlessly to different addresses.


### Scripts

1.  **READ BALANCE:** Obtain the balance of a user's vault.
2.  **SETUP CORRECTLY?:** erify the correct setup of a user's vault.
3.  **TOTAL SUPPLY:** Retrieve information on the total supply of tokens currently in circulation.

## Part 3: Transactions and Scripts Modification

### Transactions

-   **SETUP:** Identifies and rectifies poorly set up vaults.
-   **READ BALANCE:** Addresses poorly set up vaults and temporarily rectifies them to ensure accurate balance retrieval.

## Part 4: Contract Modification

### Overview


The `Admin` role is empowered to execute token withdrawals from a user's vault while concurrently depositing an equivalent value in $FLOW tokens.

### Transactions

-   **Admin Withdraw and Deposit:** Grants the Admin the authority to withdraw tokens and deposit equivalent $FLOW tokens.

## Part 5: Additional Scripts

### Scripts

1.  **Balance Summary:** Retrieves the balance of both the user's $FLOW vault and custom vault.
2.  **Vault Overview:** Presents a structured summary encompassing all official Fungible Token vaults stored within the user's account.

## Part 6: Swap Contract

### Overview

The `Swap` contract enables users to deposit $FLOW tokens and receive custom tokens in exchange. The amount received is determined by the duration since their last swap.

### Swapping Functionality

Two methods ensure user identity and authenticity:

1.  Utilization of a custom identity resource to signify identity.
2.  Verification of authenticity through reference to the user's $FLOW vault.


## End
The Flow Token project demonstrates the deployment of a customized Fungible Token contract and its versatile functionalities. Within this repository, you'll find contracts, transactions, and scripts tailored for token management, vault setup, token transfers, and token swapping. The project's clarity and manageability are enhanced by structuring code and functionalities into distinct parts.

For detailed usage guidelines and instructions, kindly consult the individual code files and accompanying comments within the repository.

