package br.com.meadote.meadote.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import br.com.meadote.meadote.models.Pessoa;

@Repository
public interface PessoaRepository extends JpaRepository<Pessoa, Integer> {

    List<Pessoa> findAll();

    Pessoa findById(int id);
}
