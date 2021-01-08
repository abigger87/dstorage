pragma solidity ^0.5.0;

contract DStorage {
    string public name = "DStorage";
    uint256 public fileCount = 0;
    mapping(uint256 => File) public files;

    struct File {
        uint256 fileId;
        string fileHash;
        uint256 fileSize;
        string fileType;
        string fileName;
        string fileDescription;
        uint256 uploadTime;
        address payable uploader;
    }

    event FileCreated(
        uint256 fileId,
        string fileHash,
        uint256 fileSize,
        string fileType,
        string fileName,
        string fileDescription,
        uint256 uploadTime,
        address payable uploader
    );

    constructor() public {}

    function uploadFile(
        string memory _fileHash,
        uint256 _fileSize,
        string memory _fileType,
        string memory _fileName,
        string memory _fileDescription
    ) public {
        require(bytes(_fileHash).length > 0, "The file hash must exist.");
        require(bytes(_fileType).length > 0, "The file type must exist.");
        require(
            bytes(_fileDescription).length > 0,
            "The file description must exist."
        );
        require(bytes(_fileName).length > 0, "The file name must exist.");
        require(msg.sender != address(0x0), "The address must not be null.");
        require(_fileSize > 0, "File size must be greater than 0");

        // Increment file id
        ++fileCount;

        // Add File to the contract
        files[fileCount] = File(
            fileCount,
            _fileHash,
            _fileSize,
            _fileType,
            _fileName,
            _fileDescription,
            now,
            msg.sender
        );

        // Trigger an event
        emit FileCreated(
            fileCount,
            _fileHash,
            _fileSize,
            _fileType,
            _fileName,
            _fileDescription,
            now,
            msg.sender
        );
    }
}
