
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

contract StoreQueue {

    string[] public queue;
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

    function excludeFirstPesron() public checkOwnerAndAccept {
        require(firstPosition < queue.length, 201, "queue is empty");
        delete queue[firstPosition];
        firstPosition++;
	}
}