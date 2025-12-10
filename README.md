# Smart Home Multi-Agent System

Sistema multi-agente para automação residencial inteligente desenvolvido com JaCaMo. O sistema monitora e controla aspectos como luminosidade, temperatura e segurança, garantindo conforto e proteção aos moradores.

## Funcionalidades

### Monitoramento e Controle

- **Segurança**: Câmera com reconhecimento de pessoas e controle de fechadura
- **Climatização**: Ar-condicionado com controle automático de temperatura
- **Iluminação**: Lâmpadas e cortinas automatizadas

### Cenários Implementados

#### 1. Proprietário Chega em Casa
Quando o agente da câmera identifica um proprietário na entrada:
- Destranca e abre a porta automaticamente
- Ajusta o ar-condicionado para a temperatura preferida
- Liga as luzes
- Ajusta as cortinas conforme preferência

#### 2. Proprietário Sai de Casa
Quando o agente da câmera detecta que o proprietário está saindo:
- Desliga o ar-condicionado
- Apaga as luzes
- Fecha as cortinas
- Fecha e tranca a porta

#### 3. Intruso Detectado
Quando um indivíduo desconhecido é detectado dentro da casa:
- Configura temperatura extrema (10°C ou 35°C aleatoriamente)
- Apaga todas as luzes para desorientar
- Fecha as cortinas para bloquear visão
- Garante que a porta está trancada
- Envia alerta de segurança

## Arquitetura do Sistema

### Grupos de Agentes

#### Agentes de Segurança
- **camera**: Monitora pessoas e identifica proprietários vs intrusos (agente coordenador)
- **fechadura**: Controla tranca e abertura/fechamento da porta

#### Agentes de Climatização
- **ar_condicionado**: Controla temperatura ambiente

#### Agentes de Iluminação
- **lampada**: Controla iluminação
- **cortina**: Controla nível de abertura das cortinas

### Comunicação entre Agentes

Os agentes se comunicam via troca de mensagens:
- Camera → Fechadura: `proprietario_chegou(Nome)`
- Camera → AC: `ajustar_para_proprietario(Nome, Temp)`
- Camera → Lampada: `ajustar_iluminacao(Nome, Estado)`
- Camera → Cortina: `ajustar_cortina(Nome, Nivel)`
- Camera → Todos: `modo_defesa` (em caso de intruso)

**Documentação Técnica:** Consulte [ARCHITECTURE.md](ARCHITECTURE.md) para detalhes sobre arquitetura, fluxos de comunicação e diagramas.

## Como Executar

### Requisitos
- Java 11 ou superior
- Gradle

### Opção 1: Testes Automatizados (Recomendado para Gitpod)

Para ambientes sem GUI ou para testes rápidos:

```bash
./test.sh
```

Ou:

```bash
./gradlew run --args="main-test.jcm"
```

Executa automaticamente os 3 cenários e exibe os resultados no console.

### Opção 2: Interface Gráfica (Recomendado para uso local)

Para usar a interface gráfica completa:

```bash
./gradlew run
```

Abre janelas GUI para cada dispositivo, permitindo controle manual e simulação interativa.

### Testar Cenários

#### Com Testes Automatizados (./test.sh):
Os 3 cenários são executados automaticamente em sequência.

#### Com Interface Gráfica (./gradlew run):

**Cenário 1 - Proprietário Chega:**
- Janela Camera: Nome = `Jonas`, Local = `entrada`, clique OK

**Cenário 2 - Proprietário Sai:**
- Janela Camera: Nome = `saindo`, Local = `entrada`, clique OK

**Cenário 3 - Intruso:**
- Janela Camera: Nome = `Desconhecido`, Local = `sala`, clique OK

## Banco de Dados de Residentes

Pessoas cadastradas no sistema:
- **Jonas**: Temperatura preferida 22°C, luzes ligadas, cortinas 50%
- **Maria**: Cadastrada como residente
- **Pedro**: Cadastrado como residente

Para adicionar novos residentes, edite o arquivo `src/agt/camera.asl` e adicione:
```prolog
pessoa_conhecida("NomeNovo").
preferencia_temperatura("NomeNovo", 23).
preferencia_iluminacao("NomeNovo", ligada).
preferencia_cortina("NomeNovo", 75).
```

## Estrutura do Projeto

```
template-mas/
├── src/
│   ├── agt/                    # Agentes
│   │   ├── camera.asl          # Coordenador de segurança
│   │   ├── fechadura.asl       # Controle de porta
│   │   ├── ar_condicionado.asl # Controle de temperatura
│   │   ├── lampada.asl         # Controle de iluminação
│   │   ├── cortina.asl         # Controle de cortinas
│   │   └── teste_automatico.asl # Testes automatizados
│   └── env/artifacts/          # Artefatos CArtAgO (Java)
├── main.jcm                    # Configuração com GUI
├── main-test.jcm               # Configuração para testes
├── test.sh                     # Script de teste
├── README.md                   # Documentação principal
├── ARCHITECTURE.md             # Arquitetura técnica
├── TESTING_GUIDE.md            # Guia de testes com GUI
└── GITPOD_GUIDE.md             # Guia para ambientes sem GUI
```

## Tecnologias Utilizadas

- **JaCaMo**: Framework para sistemas multi-agente
- **Jason**: Linguagem de programação de agentes (AgentSpeak)
- **CArtAgO**: Framework para ambientes de agentes
- **Gradle**: Sistema de build

## Comandos Úteis

```bash
# Executar testes automatizados
./test.sh

# Executar com interface gráfica
./gradlew run

# Compilar projeto
./gradlew build

# Limpar e recompilar
./gradlew clean build
```

## Tecnologias

- **JaCaMo 1.2**: Framework para sistemas multi-agente
- **Jason**: Linguagem AgentSpeak para programação de agentes
- **CArtAgO**: Framework para ambientes de agentes
- **Gradle**: Sistema de build

## Referências

- [JaCaMo](http://jacamo.sourceforge.net/)
- [Jason](http://jason.sourceforge.net/)
- [CArtAgO](http://cartago.sourceforge.net/)

