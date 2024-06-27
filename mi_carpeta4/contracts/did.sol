// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DIDRegistry {
    // Estructura para representar un documento DID
    struct DIDDocument {
        string did;
        string didDocument;
    }

    // Mapeo para almacenar los documentos DID por DID
    mapping(string => DIDDocument) private didDocuments;

    // Evento que se emite cuando se crea un DID
    event DIDCreated(string did, string didDocument);
    
    // Evento que se emite cuando se resuelve un DID
    event DIDResolved(string did, string didDocument);

    // Función para crear un nuevo DID
    function createDID(string memory _did, string memory _didDocument) public {
        // Verifica que el DID no exista ya en el registro
        require(bytes(didDocuments[_did].did).length == 0, "DID already exists");

        // Crea un nuevo documento DID
        didDocuments[_did] = DIDDocument(_did, _didDocument);

        // Emite un evento para notificar que se ha creado un nuevo DID
        emit DIDCreated(_did, _didDocument);
    }

    // Función para resolver un DID existente
    function resolveDID(string memory _did) public view returns (string memory) {
        // Verifica que el DID exista en el registro
        require(bytes(didDocuments[_did].did).length != 0, "DID does not exist");

        // Recupera el documento DID asociado al DID solicitado
        DIDDocument memory document = didDocuments[_did];

        // Devuelve el documento DID asociado al DID solicitado
        return document.didDocument;
    }

}

