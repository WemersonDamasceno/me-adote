package br.com.meadote.meadote.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.Sort;

import br.com.meadote.meadote.models.Pet;
import br.com.meadote.meadote.repositories.PetRepository;

@Service
public class PetService {

    @Autowired
    PetRepository petRepository;

    public Pet salvar(Pet pet) {
        return petRepository.save(pet);
    }

    public Pet findById(int id) {
        return petRepository.findById(id);
    }

    public List<Pet> findAll() {
        return petRepository.findAll(Sort.by(Sort.Direction.ASC, "id"));
    }

    public Pet atualizarPet(Pet pet, int id) {
        Pet petset = petRepository.findById(id);

        petset.setNome(pet.getNome());
        petset.setPeso(pet.getPeso());
        petset.setId_dono(pet.getId_dono());
        petset.setDescricao(pet.getDescricao());
        petset.setraca(pet.getraca());
        petset.setGenero(pet.getGenero());
        petset.setIdade(pet.getIdade());
        petset.setCategoria(pet.getCategoria());

        return petset;
    }

    public void deletarPet(int id) {
        petRepository.deleteById(id);
    }

    public List<Object[]> findPetByCategoria(String categoria) {
        return petRepository.findPetByCategoria(categoria);

    }

}
