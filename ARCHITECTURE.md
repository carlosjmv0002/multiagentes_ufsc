# Smart Home System - Architecture Documentation

## System Overview

The Smart Home Multi-Agent System is built using the JaCaMo framework, which combines:
- **Jason**: Agent programming language (AgentSpeak)
- **CArtAgO**: Artifact-based environment programming
- **Moise**: Organization programming (not used in this project)

## Agent Architecture

### Agent Groups

```
Smart Home System
│
├── Security Group
│   ├── camera (Coordinator)
│   └── fechadura
│
├── Climate Group
│   └── ar_condicionado
│
└── Lighting Group
    ├── lampada
    └── cortina
```

### Agent Responsibilities

#### Camera Agent (Coordinator)
- **Role**: Security monitoring and scenario coordination
- **Responsibilities**:
  - Monitor people entering/leaving
  - Identify known residents vs intruders
  - Trigger appropriate scenarios
  - Coordinate other agents via messages
- **Knowledge Base**:
  - Known residents database
  - User preferences (temperature, lighting, curtains)
- **Artifacts**: Camera (entrance monitoring)

#### Fechadura Agent
- **Role**: Door access control
- **Responsibilities**:
  - Lock/unlock door
  - Open/close door
  - Respond to security events
- **Artifacts**: Fechadura (door lock mechanism)

#### Ar_Condicionado Agent
- **Role**: Climate control
- **Responsibilities**:
  - Maintain desired temperature
  - Adjust to user preferences
  - Execute defense mode (extreme temperatures)
- **Artifacts**: ArCondicionado (AC unit with temperature simulation)

#### Lampada Agent
- **Role**: Lighting control
- **Responsibilities**:
  - Turn lights on/off
  - Respond to user preferences
  - Execute defense mode (lights off)
- **Artifacts**: Lampada (light switch)

#### Cortina Agent
- **Role**: Curtain control
- **Responsibilities**:
  - Adjust curtain opening level (0-100%)
  - Respond to user preferences
  - Execute defense mode (close curtains)
- **Artifacts**: Cortina (curtain motor)

## Communication Patterns

### Message Types

#### Scenario 1: Owner Arrives
```
camera → fechadura: proprietario_chegou(Nome)
camera → ar_condicionado: ajustar_para_proprietario(Nome, Temperatura)
camera → lampada: ajustar_iluminacao(Nome, Estado)
camera → cortina: ajustar_cortina(Nome, Nivel)
```

#### Scenario 2: Owner Leaves
```
camera → ar_condicionado: desligar_sistema
camera → lampada: desligar_sistema
camera → cortina: fechar_sistema
camera → fechadura: fechar_e_trancar
```

#### Scenario 3: Intruder Detected
```
camera → ar_condicionado: modo_defesa
camera → lampada: modo_defesa
camera → cortina: modo_defesa
camera → fechadura: modo_defesa
```

## Scenario Flow Diagrams

### Scenario 1: Owner Arrives Home

```
┌────────┐
│ Camera │ Detects known person at entrance
└───┬────┘
    │
    ├─────────────────────────────────────────┐
    │                                         │
    ▼                                         ▼
┌──────────┐                          ┌─────────────┐
│Fechadura │ Unlock & Open            │ AC/Lights/  │
│          │                          │  Curtains   │
└──────────┘                          └─────────────┘
    │                                         │
    │                                         │
    ▼                                         ▼
  Door                                  Adjust to
  Opens                                 Preferences
```

### Scenario 2: Owner Leaves Home

```
┌────────┐
│ Camera │ Detects "saindo" at entrance
└───┬────┘
    │
    ├─────────────────────────────────────────┐
    │                                         │
    ▼                                         ▼
┌──────────┐                          ┌─────────────┐
│Fechadura │ Close & Lock             │ AC/Lights/  │
│          │                          │  Curtains   │
└──────────┘                          └─────────────┘
    │                                         │
    │                                         │
    ▼                                         ▼
  Door                                   Turn Off/
  Locked                                    Close
```

### Scenario 3: Intruder Detected

```
┌────────┐
│ Camera │ Detects unknown person
└───┬────┘
    │
    │ SECURITY ALERT!
    │
    ├──────────┬──────────┬──────────┬──────────┐
    │          │          │          │          │
    ▼          ▼          ▼          ▼          ▼
┌────────┐ ┌────┐ ┌────────┐ ┌────────┐ ┌──────────┐
│   AC   │ │Lamp│ │Curtain │ │  Door  │ │  Alert   │
│Extreme │ │Off │ │ Close  │ │  Lock  │ │  Owner   │
│  Temp  │ │    │ │        │ │        │ │          │
└────────┘ └────┘ └────────┘ └────────┘ └──────────┘
```

## Artifact Design

### CArtAgO Artifacts

Each artifact provides:
- **Observable Properties**: State that agents can perceive
- **Operations**: Actions agents can perform
- **Signals**: Events that trigger agent reactions
- **GUI Interface**: Manual control for testing

#### Camera Artifact
- **Properties**: `ligada`, `local`, `pessoa_presente`
- **Operations**: `ligar()`, `desligar()`
- **Signals**: `movimento` (when person detected)
- **GUI**: Input fields for person name and location

#### Fechadura Artifact
- **Properties**: `fechada`, `trancada`
- **Operations**: `abrir()`, `fechar()`, `trancar()`, `destrancar()`
- **Signals**: `movimento_macaneta`, `movimento_fechadura`
- **GUI**: Buttons for door handle and lock

#### ArCondicionado Artifact
- **Properties**: `ligado`, `temperatura_ambiente`, `temperatura_ac`
- **Operations**: `ligar()`, `desligar()`, `definir_temperatura(int)`
- **Signals**: `alterado` (when temperature changed)
- **GUI**: Input fields for current and desired temperature
- **Simulation**: Thread that gradually adjusts ambient temperature

#### Lampada Artifact
- **Properties**: `ligada`
- **Operations**: `ligar()`, `desligar()`
- **Signals**: `interuptor` (when switch toggled)
- **GUI**: Toggle button

#### Cortina Artifact
- **Properties**: `nivel_abertura` (0-100%)
- **Operations**: `abrir()`, `fechar()`, `aumentar_nivel()`, `diminuir_nivel()`
- **Signals**: `ajuste_cortina` (when level changed)
- **GUI**: Input field for opening level

## Decision Logic

### Camera Agent Decision Tree

```
Person Detected
│
├─ Is person known?
│  │
│  ├─ YES → Is at entrance?
│  │  │
│  │  ├─ YES → Scenario 1: Welcome home
│  │  └─ NO → Log movement
│  │
│  └─ NO → Is person "saindo"?
│     │
│     ├─ YES → Scenario 2: Leaving home
│     └─ NO → Scenario 3: INTRUDER ALERT!
│
└─ No person → Idle monitoring
```

### Defense Mode Strategy

When intruder detected, the system employs multiple tactics:

1. **Temperature Discomfort**: Randomly set to 10°C (very cold) or 35°C (very hot)
2. **Visual Disorientation**: Turn off all lights
3. **Privacy Protection**: Close all curtains
4. **Physical Security**: Ensure all doors are locked
5. **Alert**: Notify owners (simulated via console message)

## Extension Points

### Adding New Residents

Edit `src/agt/camera.asl`:
```prolog
pessoa_conhecida("NewName").
preferencia_temperatura("NewName", 24).
preferencia_iluminacao("NewName", ligada).
preferencia_cortina("NewName", 75).
```

### Adding New Rooms

1. Create new artifact instances in agent initialization
2. Update camera to monitor multiple locations
3. Add room-specific preferences

### Adding New Device Types

1. Create new Java artifact in `src/env/artifacts/`
2. Create new agent in `src/agt/`
3. Add agent to `main.jcm`
4. Update camera agent to coordinate with new device

### Adding New Scenarios

Add new message handlers in relevant agents:
```prolog
+new_scenario_trigger
    <- .send(agent_name, tell, new_action);
       !execute_new_behavior.
```

## Performance Considerations

- **Message Passing**: Asynchronous, non-blocking
- **Temperature Simulation**: Runs in separate thread, updates every 5 seconds
- **GUI Updates**: Event-driven, minimal overhead
- **Agent Reasoning**: Reactive (event-driven) + Proactive (goal-driven)

## Security Considerations

- **Known Residents**: Stored in agent beliefs (in production, use secure database)
- **Intruder Detection**: Based on name matching (in production, use biometric/facial recognition)
- **Defense Mode**: Automated response (in production, add manual override)
- **Notifications**: Console logging (in production, integrate with SMS/email/app)

## Testing Strategy

1. **Unit Testing**: Test individual agent behaviors
2. **Integration Testing**: Test agent communication
3. **Scenario Testing**: Test complete workflows
4. **GUI Testing**: Manual testing via artifact interfaces

See [TESTING_GUIDE.md](TESTING_GUIDE.md) for detailed testing procedures.
