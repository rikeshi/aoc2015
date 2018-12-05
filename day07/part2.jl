abstract type Gate end

struct Circuit
  wires::Dict{String,UInt16}
  gates::Array{Gate}

  function Circuit()
    new(Dict(), [])
  end
end

struct UnaryGate{T,U} <: Gate
  activate::T
  in::U
  out::String
end

struct BinaryGate{T,U,V} <: Gate
  activate::T
  in1::U
  in2::V
  out::String
end


function AND(wires, in1::String, in2, out)
  wires[out] = wires[in1] & wires[in2]
end

function AND(wires, in1::UInt16, in2, out)
  wires[out] = in1 & wires[in2]
end

function OR(wires, in1::String, in2, out)
  wires[out] = wires[in1] | wires[in2]
end

function OR(wires, in1::UInt16, in2, out)
  wires[out] = in1 | wires[in2]
end

function LSHIFT(wires, in, shift, out)
  wires[out] = wires[in] << shift
end

function RSHIFT(wires, in, shift, out)
  wires[out] = wires[in] >> shift
end

function NOT(wires, in, out)
  wires[out] = ~wires[in]
end

function COPY(wires, in::String, out)
  wires[out] = wires[in]
end

function COPY(wires, in::UInt16, out)
  wires[out] = in
end


function activate(wires, gate::UnaryGate)
  gate.activate(wires, gate.in, gate.out)
end

function activate(wires, gate::BinaryGate)
  gate.activate(wires, gate.in1, gate.in2, gate.out)
end


function read_and_construct(circuit, fname)
  for line in eachline(fname)
    p = map(string, split(line))
    gate = if length(p) == 3
      x = try parse(UInt16, p[1]) catch; p[1] end
      UnaryGate(COPY, x, p[3])
    elseif length(p) == 4
      UnaryGate(NOT, p[2], p[4])
    elseif length(p) == 5
      if p[2] == "AND"
        x = try parse(UInt16, p[1]) catch; p[1] end
        BinaryGate(AND, x, p[3], p[5])
      elseif p[2] == "OR"
        BinaryGate(OR, p[1], p[3], p[5])
      else
        op = if p[2] == "LSHIFT"
          LSHIFT
        elseif p[2] == "RSHIFT"
          RSHIFT
        end
        x = try parse(UInt16, p[3]) catch; p[3] end
        BinaryGate(op, p[1], x, p[5])
      end
    end
    push!(circuit.gates, gate)
  end
end


function create_wires(circuit)
  wires = circuit.wires
  for gate in circuit.gates
    if isa(gate, UnaryGate)
      if isa(gate.in , String) wires[gate.in]  = 0 end
      if isa(gate.out, String) wires[gate.out] = 0 end
    elseif isa(gate, BinaryGate)
      if isa(gate.in1, String) wires[gate.in1] = 0 end
      if isa(gate.in2, String) wires[gate.in2] = 0 end
      if isa(gate.out, String) wires[gate.out] = 0 end
    end
  end
end


function emulate(circuit)
  wires = circuit.wires
  prev = copy(wires)
  while true
    for gate in circuit.gates
      if isa(gate, UnaryGate) && isa(gate.in, UInt16)
        continue
      end
      activate(wires, gate)
    end
    if prev == wires println(wires["a"]); break end
    prev = copy(wires)
  end
end


circuit = Circuit()
read_and_construct(circuit, "input")
create_wires(circuit)
circuit.wires["b"] = 46065
emulate(circuit)
