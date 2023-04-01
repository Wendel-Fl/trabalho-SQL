SELECT *
FROM venda

SELECT *
FROM venda_garantia

SELECT *
FROM pessoa pes
INNER JOIN cliente cl ON pes.cpf = cl.cpf_pessoa

SELECT *
FROM pessoa pes
INNER JOIN funcionario_vendedor fv ON pes.cpf = fv.cpf_pessoa

SELECT *
FROM pessoa pes
INNER JOIN funcionario_gerente fg ON pes.cpf = fg.cpf_pessoa

SELECT pd.nome, pd.marca, 'R$ ' || TO_CHAR(pd.preco, '999G999D99') AS preco, pd.descricao
FROM venda vd
INNER JOIN venda_garantia vg ON vd.numero_nf = vg.numero_nf
INNER JOIN produto pd ON vg.codigo_produto = pd.codigo_produto

SELECT pes.nome, fv.data_contrato
FROM pessoa pes
INNER JOIN funcionario_vendedor fv ON pes.cpf = fv.cpf_pessoa
ORDER BY fv.data_contrato ASC

SELECT pd.nome
FROM produto pd
INNER JOIN venda_garantia vg ON pd.codigo_produto = vg.codigo_produto
INNER JOIN venda vd ON vd.numero_nf = vg.numero_nf
GROUP BY pd.nome

SELECT *
FROM produto
WHERE nome LIKE 'Ca%'

SELECT 'R$ ' || TO_CHAR(MAX(preco), '999G999D99') AS preco
FROM produto

SELECT pes.nome, 'R$ ' || TO_CHAR(SUM(pa.valor * pa.numero_parcela), '999G999D99') AS valor_total
FROM pessoa pes
INNER JOIN venda vd ON pes.cpf = vd.cpf_cliente
INNER JOIN parcelas pa ON vd.numero_nf = pa.numero_nf_venda
GROUP BY pes.nome
ORDER BY pes.nome ASC

SELECT pes.nome
FROM pessoa pes
INNER JOIN cliente ON pes.cpf = cliente.cpf_pessoa
WHERE NOT EXISTS(
	SELECT *
	FROM venda
	WHERE cliente.cpf_pessoa = venda.cpf_cliente
)

SELECT nome
FROM pessoa, funcionario_gerente
WHERE pessoa.cpf = funcionario_gerente.cpf_pessoa
UNION
SELECT nome
FROM pessoa, funcionario_vendedor
WHERE pessoa.cpf = funcionario_vendedor.cpf_pessoa

SELECT descricao_atividade
FROM estoque_historico_resp
WHERE protocolo IN (
	SELECT protocolo
	FROM estoque_historico
)

SELECT descricao_atividade
FROM estoque_historico_resp

SELECT COUNT(*) AS numero_clientes
FROM cliente

SELECT nome, COUNT(*) AS compras
FROM pessoa pes
INNER JOIN cliente cl ON pes.cpf = cl.cpf_pessoa
INNER JOIN venda vd ON cl.cpf_pessoa = vd.cpf_cliente
GROUP BY nome