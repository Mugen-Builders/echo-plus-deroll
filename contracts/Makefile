-include .env

.PHONY: deploy env test

info: header

define HEADER    

███████╗ ██████╗██╗  ██╗ ██████╗       ██████╗ ██╗     ██╗   ██╗███████╗      ██████╗ ███████╗██████╗  ██████╗ ██╗     ██╗     
██╔════╝██╔════╝██║  ██║██╔═══██╗      ██╔══██╗██║     ██║   ██║██╔════╝      ██╔══██╗██╔════╝██╔══██╗██╔═══██╗██║     ██║     
█████╗  ██║     ███████║██║   ██║█████╗██████╔╝██║     ██║   ██║███████╗█████╗██║  ██║█████╗  ██████╔╝██║   ██║██║     ██║     
██╔══╝  ██║     ██╔══██║██║   ██║╚════╝██╔═══╝ ██║     ██║   ██║╚════██║╚════╝██║  ██║██╔══╝  ██╔══██╗██║   ██║██║     ██║     
███████╗╚██████╗██║  ██║╚██████╔╝      ██║     ███████╗╚██████╔╝███████║      ██████╔╝███████╗██║  ██║╚██████╔╝███████╗███████╗
╚══════╝ ╚═════╝╚═╝  ╚═╝ ╚═════╝       ╚═╝     ╚══════╝ ╚═════╝ ╚══════╝      ╚═════╝ ╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚══════╝
                                                    
 ██████╗ ██████╗ ███╗   ██╗████████╗██████╗  █████╗  ██████╗████████╗███████╗
██╔════╝██╔═══██╗████╗  ██║╚══██╔══╝██╔══██╗██╔══██╗██╔════╝╚══██╔══╝██╔════╝
██║     ██║   ██║██╔██╗ ██║   ██║   ██████╔╝███████║██║        ██║   ███████╗
██║     ██║   ██║██║╚██╗██║   ██║   ██╔══██╗██╔══██║██║        ██║   ╚════██║
╚██████╗╚██████╔╝██║ ╚████║   ██║   ██║  ██║██║  ██║╚██████╗   ██║   ███████║
 ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝   ╚═╝   ╚══════╝

endef

export HEADER

# DEFAULT VARIABLES
START_LOG = @echo "======================================================= START OF LOG ========================================================="
END_LOG = @echo "======================================================== END OF LOG =========================================================="

ifneq ($(NETWORK), "localhost")
	RPC_URL := $(RPC_URL)
	PRIVATE_KEY := $(PRIVATE_KEY)
	DEPLOY_NETWORK_ARGS := script/DeployDeployerPlugin.s.sol --rpc-url $(RPC_URL) --private-key $(PRIVATE_KEY) --broadcast --verify --etherscan-api-key $(BLOCKSCAN_API_KEY) -vvvvv
else
	RPC_URL := "http://localhost:8545"
	PRIVATE_KEY := "0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80"
	DEPLOY_NETWORK_ARGS := script/DeployDeployerPlugin.s.sol --rpc-url $(RPC_URL) --private-key $(PRIVATE_KEY) --broadcast -vvvvv
endif

define test_contracts
	$(START_LOG)
	@forge test
	$(END_LOG)
endef

define deploy_contracts
	$(START_LOG)
	@forge script $(DEPLOY_NETWORK_ARGS)
	$(END_LOG)
endef

env: .env.tmpl
	cp .env.tmpl .env

test:
	@echo "$$HEADER"
	@$(test_contracts)

deploy:
	@echo "$$HEADER"
	@$(deploy_contracts)
                                                                                                                               
