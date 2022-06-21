package br.com.meadote.meadote.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.Sort;

import br.com.meadote.meadote.models.Pessoa;
import br.com.meadote.meadote.repositories.PessoaRepository;

@Service
public class PessoaService {

    @Autowired
    PessoaRepository pessoaRepository;

    public Pessoa salvarPessoa(Pessoa pessoa) {
        return pessoaRepository.save(pessoa);
    }

    public Pessoa findById(int id) {
        return pessoaRepository.findById(id);
    }

    public List<Pessoa> findAll() {
        return pessoaRepository.findAll((Sort.by(Sort.Direction.ASC, "id")));
    }

    public Pessoa atualizarPessoa(Pessoa pessoa, int id) {
        Pessoa pessoaset = pessoaRepository.findById(id);

        pessoaset.setId(pessoa.getId());
        pessoaset.setNome(pessoa.getNome());
        pessoaset.setEmail(pessoa.getEmail());
        pessoaset.setPetFavorites(pessoa.getPetFavorites());
        pessoaset.setUrlPerfil(pessoa.getUrlPerfil());

        return pessoaset;
    }

    public void deletarPessoa(int id) {
        pessoaRepository.deleteById(id);
    }

}
