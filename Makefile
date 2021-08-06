build:
	solc contracts/yul/main.yul --strict-assembly --optimize
run:
	go run cmd/bot/main.go
deploy: 
	@go run scripts/deploy/deploy.go -bin $(bin)
call:
	@go run scripts/call/call.go -to $(to) -data $(data)
transact:
	@go run scripts/transact/transact.go -to $(to) -data $(data)
