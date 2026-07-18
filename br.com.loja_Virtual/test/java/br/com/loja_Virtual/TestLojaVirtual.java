package br.com.loja_Virtual;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import br.com.loja_Virtual.controller.AcessoController;
import br.com.loja_Virtual.model.Acesso;

@SpringBootTest(classes = LojaVirtualApplication.class)
public class TestLojaVirtual {
	@Autowired
	private AcessoController acessoController;
	
	@Test
	public void testeControleAcesso() {
		Acesso acesso = new Acesso();
		acesso.setDescricao("ROLE_ADMIN");
		acessoController.salvarAcesso(acesso);
		
	}
}
