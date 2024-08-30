***GreenCredits***

GreenCredits is a blockchain-based platform that enables the transparent trading of carbon credits. By leveraging Hyperledger Fabric, the platform can ensure that all transactions are recorded immutably, and all parties involved can access the same version of the truth.

**Pre-requisites**

To run the application, install the following:

1. Docker compose
2. Go

**Hyperledger Fabric network**

Build the Hyperledger Fabric network and deploy the chaincode by executing the following commands

```cd GreenCredits/Network```

```./startNetwork.sh```

**Run the UI**

Navigate to Simple_App folder

```cd GreenCredits/Simple_App```

```go run .```

Access the UI at http://localhost:8000/

Click on the `Login` button and then select `Login as Government Agency`. 

The Government Agency has the privilege to `Initialize` the token where it can define a name, symbol and decimal values for the token. Do this initialize option only once.

Click on `Mint` to mint new tokens. 

Click on `Allocate` to allocate some tokens to NGO's to issue them to corporates.

Login as NGO to issue the tokens to corporates.

Login as Corporate to transfer the tokens to other corporates.

Stop the UI by `crtl+c` from the terminal where we are running the go application.

**Stop the network**

```cd GreenCredits/Network```

```./stopNetwork.sh```






   
