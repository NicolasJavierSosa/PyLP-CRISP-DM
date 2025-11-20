:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_json)).

% -------------------------
% START SERVER
% -------------------------
start_api :-
    http_server(http_dispatch, [port(8080)]).

% -------------------------
% HOME - HTML minimalista
% -------------------------
:- http_handler(root(.), home_handler, []).

home_handler(_Request) :-
    format('Content-type: text/html~n~n'),
    format('<!DOCTYPE html>'),
    format('<html>'),
    format('<head>'),
    format('<meta charset="UTF-8">'),
    format('<title>Programación lógica</title>'),
    format('<script src="https://cdn.tailwindcss.com"></script>'),
    format('</head>'),
    format('<body class="bg-gray-900 p-4">'),
    
    format('<div class="max-w-md mx-auto mt-10 bg-gray-800 p-6 rounded-lg">'),
    format('<h1 class="text-2xl text-white text-center mb-6">Programación lógica</h1>'),
    
    format('<form id="form">'),
    format('<div class="mb-4">'),
    format('<label class="text-white block mb-2">Horas estudiadas</label>'),
    format('<input type="number" id="hours" class="w-full p-2 rounded" required>'),
    format('</div>'),
    
    format('<div class="mb-4">'),
    format('<label class="text-white block mb-2">Asistencia (%)</label>'),
    format('<input type="number" id="attendance" class="w-full p-2 rounded" required>'),
    format('</div>'),
    
    format('<div class="mb-4">'),
    format('<label class="text-white block mb-2">Puntaje previo</label>'),
    format('<input type="number" id="previous" class="w-full p-2 rounded" required>'),
    format('</div>'),
    
    format('<button type="submit" class="w-full bg-blue-600 text-white p-2 rounded">Predecir</button>'),
    format('</form>'),
    
    format('<div id="result" class="mt-6 p-4 bg-gray-700 text-white rounded text-center">Esperando datos...</div>'),
    
    format('</div>'),
    
    format('<script>'),
    format('document.getElementById("form").addEventListener("submit", async function(e) {'),
    format('e.preventDefault();'),
    format('const resultDiv = document.getElementById("result");'),
    format('resultDiv.innerHTML = "Procesando...";'),
    format('const data = {'),
    format('hours_studied: parseFloat(document.getElementById("hours").value),'),
    format('attendance_percent: parseFloat(document.getElementById("attendance").value),'),
    format('previous_scores: parseFloat(document.getElementById("previous").value)'),
    format('};'),
    format('try {'),
    format('const response = await fetch("/infer", {'),
    format('method: "POST",'),
    format('headers: {"Content-Type": "application/json"},'),
    format('body: JSON.stringify(data)'),
    format('});'),
    format('const result = await response.json();'),
    format('resultDiv.innerHTML = "Resultado: " + result.resultado;'),
    format('} catch (error) {'),
    format('resultDiv.innerHTML = "Error: " + error.message;'),
    format('}'),
    format('});'),
    format('</script>'),
    
    format('</body>'),
    format('</html>').

% -------------------------
% API /infer (JSON)
% -------------------------
:- http_handler(root(infer), infer_handler, []).

infer_handler(Request) :-
    http_read_json_dict(Request, Datos),
    HS = Datos.get(hours_studied),
    AP = Datos.get(attendance_percent),
    PS = Datos.get(previous_scores),
    regla(HS, AP, PS, Resultado),
    reply_json_dict(_{resultado: Resultado}).

% -------------------------
% SISTEMA EXPERTO BASADO EN REGLAS
% -------------------------

% Regla 1
regla(HS, AP, _PS, "Y") :-
    HS > 11.150,
    AP > 78.950, !.

% Regla 2
regla(HS, AP, _PS, "N") :-
    HS > 11.150,
    AP =< 78.950,
    AP > 69.600, !.

% Regla 3
regla(HS, AP, _PS, "Y") :-
    HS > 11.150,
    AP =< 69.600, !.

% Regla 4
regla(HS, _AP, PS, "Y") :-
    HS =< 11.150,
    HS > 8.950,
    PS > 82, !.

% Regla 5
regla(HS, _AP, PS, "N") :-
    HS =< 11.150,
    HS > 8.950,
    PS =< 82, !.

% Regla 6
regla(HS, AP, _PS, "Y") :-
    HS =< 8.950,
    AP > 97.800, !.

% Regla 7
regla(HS, AP, _PS, "N") :-
    HS =< 8.950,
    AP =< 97.800, !.

% Si nada matchea (fallback)
regla(_, _, _, "N").