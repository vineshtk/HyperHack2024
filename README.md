***GreenCredits***

GreenCredits is a blockchain-based platform that enables the transparent trading of carbon credits. By leveraging Hyperledger Fabric, the platform can ensure that all transactions are recorded immutably, and all parties involved can access the same version of the truth.

**Pre-requisites**

To run the application, install the following:

1. Docker compose
2. Go
3. NodeJS, NPM

**Hyperledger Fabric network**

Build the Hyperledger Fabric network and deploy the chaincode by executing the following commands

```cd GreenCredits/Network```

```./startNetwork.sh```

**Run the UI**

Navigate to Simple_App folder

```cd GreenCredits/Simple_App```

```go run .```

Access the UI at http://localhost:8000/




   
