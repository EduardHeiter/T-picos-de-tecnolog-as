// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract GestorTareas {
    uint256 public contadorTareas = 0;

    struct Tarea {
        uint256 id;
        string titulo;
        string descripcion;
        bool completada;
        address creador;
    }

    mapping(uint256 => Tarea) public tareas;

    event TareaCreada(uint256 id, string titulo, string descripcion, bool completada, address creador);
    event TareaCompletada(uint256 id, bool completada);

    // Funcion para crear una nueva tarea
    function crearTarea(string memory _titulo, string memory _descripcion) public {
        contadorTareas++;
        tareas[contadorTareas] = Tarea(contadorTareas, _titulo, _descripcion, false, msg.sender);
        emit TareaCreada(contadorTareas, _titulo, _descripcion, false, msg.sender);
    }

    // Funcion para marcar una tarea como completada
    function completarTarea(uint256 _id) public {
        require(_id > 0 && _id <= contadorTareas, "La tarea no existe.");
        Tarea storage tarea = tareas[_id];
        require(tarea.creador == msg.sender, "Solo el creador puede completar la tarea.");
        require(!tarea.completada, "La tarea ya esta completada.");
        tarea.completada = true;
        emit TareaCompletada(_id, true);
    }

    // Funcion para obtener una tarea
    function obtenerTarea(uint256 _id) public view returns (uint256, string memory, string memory, bool, address) {
        require(_id > 0 && _id <= contadorTareas, "La tarea no existe.");
        Tarea memory tarea = tareas[_id];
        return (tarea.id, tarea.titulo, tarea.descripcion, tarea.completada, tarea.creador);
    }
}
