SELECT proprietario.nome, proprietario.cpf, unidade.numero, unidade.bloco
FROM proprietario
JOIN unidade ON unidade.id_proprietario = proprietario.id_proprietario
WHERE unidade.bloco = 'A'
ORDER BY proprietario.nome;

SELECT condominio.nome AS nome_condominio, sindico.nome AS nome_sindico
FROM condominio
JOIN sindico ON condominio.id_sindico = sindico.id_sindico
WHERE condominio.cidade = 'São Paulo'
ORDER BY condominio.nome;

SELECT funcionario.nome, funcionario.cargo, condominio.nome AS nome_condominio
FROM funcionario
JOIN funcionario_condominio ON funcionario.id_funcionario = funcionario_condominio.id_funcionario
JOIN condominio ON funcionario_condominio.id_condominio = condominio.id_condominio
WHERE funcionario.cargo = 'Zelador'
ORDER BY funcionario.nome;

SELECT conta_bancaria.banco, conta_bancaria.agencia, conta_bancaria.conta_com_digito, condominio.nome AS nome_condominio
FROM conta_bancaria
JOIN condominio ON conta_bancaria.id_condominio = condominio.id_condominio
WHERE conta_bancaria.banco = 'Itaú'
ORDER BY condominio.nome;

SELECT sindico.nome, sindico.venc_mandato
FROM sindico
WHERE sindico.venc_mandato > '2027-01-01'
ORDER BY sindico.venc_mandato;

SELECT funcionario.nome, funcionario.cargo, funcionario.salario
FROM funcionario
WHERE funcionario.salario > 1700.00
ORDER BY funcionario.salario DESC;

SELECT condominio.nome AS nome_condominio, unidade.numero, unidade.bloco, proprietario.nome AS nome_proprietario
FROM unidade
JOIN condominio ON unidade.id_condominio = condominio.id_condominio
JOIN proprietario ON unidade.id_proprietario = proprietario.id_proprietario
WHERE condominio.nome = 'Residencial das Flores'
ORDER BY unidade.numero;

SELECT proprietario.nome, proprietario_email.email
FROM proprietario
JOIN proprietario_email ON proprietario.id_proprietario = proprietario_email.id_proprietario
WHERE proprietario_email.email LIKE '%@gmail.com'
ORDER BY proprietario.nome;

SELECT condominio.nome, condominio.cidade, condominio.bairro
FROM condominio
WHERE condominio.cidade IN ('Santos', 'Campinas')
ORDER BY condominio.cidade, condominio.nome;

SELECT sindico.nome, COUNT(condominio.id_condominio) AS qtd_condominios
FROM sindico
JOIN condominio ON sindico.id_sindico = condominio.id_sindico
GROUP BY sindico.nome
ORDER BY qtd_condominios DESC;
