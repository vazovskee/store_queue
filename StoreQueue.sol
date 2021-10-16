
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

contract StoreQueue {

    string[] private queue;      // массив для хранения имён людей в очереди
    uint private firstPosition;  // переменная для хранения позиции первого человека в очереди

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

    // функция для добавления имени человека в конец массива
	function addPerson(string name) public checkOwnerAndAccept {
        queue.push(name);
	}

    // функция, которая удаляет имя первого человека из очереди и возвращает его значение
    function getPersonOut() public checkOwnerAndAccept returns (string) {
        require(firstPosition < queue.length, 201, "queue is empty"); // проверка на выход за границы массива
        
        string leavingPerson = queue[firstPosition];
        delete queue[firstPosition];
        firstPosition++;
        
        return leavingPerson;
	}
}