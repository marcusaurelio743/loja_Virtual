package br.com.loja_Virtual.enums;

public enum TipoEndereco {
	
	COBRANCA("cobrança"),
	ENTREGA("entrega");
	
	private String descricao;
		
	private TipoEndereco(String descricao) {
		this.descricao = descricao;
	}
	
	public String getDescricao() {
		return descricao;
	}
	
	@Override
	public String toString() {
		return this.descricao;
	}

}
