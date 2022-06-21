package br.com.meadote.meadote.repositories;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import br.com.meadote.meadote.models.Pet;

@Repository
@Transactional
public interface PetRepository extends JpaRepository<Pet, Integer> {

    @Query(value = "SELECT u FROM Pet u WHERE u.categoria = :categoria")
    List<Object[]> findPetByCategoria(@Param("categoria") String categoria);

    List<Pet> findAll();

    Pet findById(int id);

}
