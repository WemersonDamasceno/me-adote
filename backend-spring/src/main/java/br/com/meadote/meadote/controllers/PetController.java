package br.com.meadote.meadote.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import br.com.meadote.meadote.models.Pet;
import br.com.meadote.meadote.services.PetService;

@RestController
@RequestMapping("/api/pet")
public class PetController {

    @Autowired
    PetService petService;

    @PostMapping
    public ResponseEntity<Pet> savePet(@RequestBody Pet pet) {
        return ResponseEntity.status(HttpStatus.CREATED).body(petService.salvar(pet));
    }

    @GetMapping("")
    public ResponseEntity<List<Pet>> findAll() {
        return ResponseEntity.ok(petService.findAll());
    }

    @GetMapping("{id}")
    public ResponseEntity<Pet> findById(@PathVariable int id) {
        return ResponseEntity.status(HttpStatus.CREATED).body(petService.findById(id));
    }

    @PutMapping("{id}")
    public ResponseEntity<Pet> update(@RequestBody Pet pet, @PathVariable int id) {
        Pet newpet = petService.atualizarPet(pet, id);

        petService.atualizarPet(newpet, id);

        return ResponseEntity.noContent().build();
    }

    @DeleteMapping("{id}")
    public ResponseEntity<Pet> deletePet(@PathVariable int id) {
        petService.deletarPet(id);
        return ResponseEntity.noContent().build();
    }

    @GetMapping("/findpetbycategoria/{categoria}")
    public ResponseEntity<List<Object[]>> findpetByCategoria(@PathVariable("categoria") String categoria) {
        return ResponseEntity.ok(petService.findPetByCategoria(categoria));
    }

}
