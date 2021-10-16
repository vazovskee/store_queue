
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

contract StoreQueue {

    string[] private queue;
    uint private firstPosition;

    constructor() public {
        require(tvm.pubkey() != 0, 101);
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
    }

    modifier checkOwnerAndAccept {
		require(msg.pubkey() == tvm.pubkey(), 102);
		tvm.accept();
		_;
	}

	function addPerson(string name) public checkOwnerAndAccept {
        queue.push(name);
	}

    function getPersonOut() public checkOwnerAndAccept returns (string) {
        require(firstPosition < queue.length, 201, "queue is empty");
        
        string leavingPerson = queue[firstPosition];
        delete queue[firstPosition];
        firstPosition++;
        
        return leavingPerson;
	}
}