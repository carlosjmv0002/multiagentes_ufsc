# Guia de Execução no Gitpod

## Problema: Interface Gráfica no Gitpod

O Gitpod não possui suporte nativo para interfaces gráficas Java Swing/AWT. Por isso, criamos uma **versão de teste automatizada** que executa os 3 cenários sem necessidade de GUI.

## ✅ Solução: Testes Automatizados (Recomendado para Gitpod)

Execute os testes automatizados que demonstram todos os cenários:

```bash
./gradlew run --args="main-test.jcm"
```

### O que você verá:

```
========================================
INICIANDO TESTES AUTOMATICOS
========================================

========================================
TESTE CENARIO 1: PROPRIETARIO CHEGA
========================================
Simulando: Jonas detectado na entrada
=== BEM-VINDO! ===
Proprietario Jonas detectado na entrada.
Iniciando protocolo de chegada...
Porta aberta para Jonas.
Ajustando AC para preferencia de Jonas: 22C
Ligando luzes para Jonas
Cortina ajustada para 50%.
Ambiente configurado para Jonas.

========================================
TESTE CENARIO 2: PROPRIETARIO SAI
========================================
Simulando: Proprietario saindo
=== SAIDA DETECTADA ===
Proprietario saindo de casa.
Iniciando protocolo de saida...
AC desligado.
Lampada desligada.
Cortina fechada.
Porta Trancada!
Casa segura. Todos os sistemas desligados.

========================================
TESTE CENARIO 3: INTRUSO DETECTADO
========================================
Simulando: Pessoa desconhecida na sala
!!! ALERTA DE SEGURANCA !!!
INTRUSO DETECTADO: Desconhecido no local: sala
Ativando modo de defesa...
MODO DE DEFESA: Configurando temperatura extrema!
Configurando temperatura MUITO QUENTE (35C)!
MODO DE DEFESA: Apagando todas as luzes!
MODO DE DEFESA: Fechando cortinas completamente!
MODO DE DEFESA ATIVADO!

========================================
TESTES CONCLUIDOS
========================================
```

## 🖥️ Alternativa: Executar Localmente com GUI

Para usar a interface gráfica completa, clone o repositório na sua máquina:

```bash
git clone https://github.com/Liga-IA/template-mas.git
cd template-mas
./gradlew run
```

As janelas GUI aparecerão automaticamente e você poderá:
- Controlar manualmente cada dispositivo
- Simular os cenários através da interface da câmera
- Ver as mudanças em tempo real

## 📊 Comparação das Versões

| Recurso | Versão GUI (Local) | Versão Teste (Gitpod) |
|---------|-------------------|----------------------|
| Interface Gráfica | ✅ Sim | ❌ Não |
| Testes Automatizados | ❌ Não | ✅ Sim |
| Controle Manual | ✅ Sim | ❌ Não |
| Funciona no Gitpod | ❌ Não | ✅ Sim |
| Demonstra Cenários | ✅ Sim | ✅ Sim |
| Comunicação entre Agentes | ✅ Sim | ✅ Sim |

## 🔍 Como Funciona a Versão de Teste

A versão de teste (`main-test.jcm`) inclui um agente adicional chamado `teste_automatico` que:

1. Aguarda a inicialização de todos os agentes
2. Envia mensagens simulando os 3 cenários
3. Aguarda as respostas dos agentes
4. Exibe os resultados no console

Os agentes funcionam **exatamente da mesma forma**, apenas sem as interfaces gráficas.

## 📝 Arquivos Importantes

- `main.jcm` - Configuração original (requer GUI)
- `main-test.jcm` - Configuração para testes automatizados (sem GUI)
- `src/agt/teste_automatico.asl` - Agente que executa os testes

## 🎯 Verificando os Resultados

Ao executar os testes, observe:

### Cenário 1 (Proprietário Chega):
- ✅ Mensagem de boas-vindas
- ✅ Porta destrancada e aberta
- ✅ AC ajustado para 22°C
- ✅ Luzes ligadas
- ✅ Cortinas ajustadas para 50%

### Cenário 2 (Proprietário Sai):
- ✅ Detecção de saída
- ✅ AC desligado
- ✅ Luzes desligadas
- ✅ Cortinas fechadas
- ✅ Porta fechada e trancada

### Cenário 3 (Intruso):
- ✅ Alerta de segurança
- ✅ Temperatura extrema (10°C ou 35°C)
- ✅ Luzes apagadas
- ✅ Cortinas fechadas
- ✅ Porta trancada
- ✅ Notificação enviada

## 🚀 Comandos Úteis

```bash
# Executar testes automatizados
./gradlew run --args="main-test.jcm"

# Compilar o projeto
./gradlew build

# Limpar e recompilar
./gradlew clean build

# Ver logs detalhados
./gradlew run --args="main-test.jcm" --info
```

## 💡 Dicas

1. **Leia o console atentamente**: Todas as ações dos agentes são registradas
2. **Observe a ordem**: Os agentes se comunicam de forma assíncrona
3. **Aguarde a conclusão**: Os testes levam cerca de 15-20 segundos
4. **Execute múltiplas vezes**: Veja a aleatoriedade no modo de defesa (temperatura)

## 📚 Documentação Adicional

- [README.md](README.md) - Visão geral do sistema
- [TESTING_GUIDE.md](TESTING_GUIDE.md) - Guia de testes com GUI
- [ARCHITECTURE.md](ARCHITECTURE.md) - Arquitetura técnica
- [QUICKSTART.md](QUICKSTART.md) - Início rápido

## ❓ Perguntas Frequentes

**P: Por que não vejo as janelas?**
R: O Gitpod não suporta GUI Java. Use a versão de teste automatizada.

**P: Os agentes funcionam da mesma forma?**
R: Sim! A lógica é idêntica, apenas sem interface gráfica.

**P: Posso modificar os testes?**
R: Sim! Edite `src/agt/teste_automatico.asl` para adicionar novos cenários.

**P: Como adicionar novos residentes?**
R: Edite `src/agt/camera.asl` e adicione as linhas:
```prolog
pessoa_conhecida("NomeNovo").
preferencia_temperatura("NomeNovo", 24).
preferencia_iluminacao("NomeNovo", ligada).
preferencia_cortina("NomeNovo", 75).
```

## ✅ Conclusão

A versão de teste automatizada demonstra **todas as funcionalidades** do sistema multi-agente sem necessidade de interface gráfica, sendo perfeita para ambientes como o Gitpod!
