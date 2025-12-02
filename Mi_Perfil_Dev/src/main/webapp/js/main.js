/**
 * Script principal para la interfaz de usuario
 */

document.addEventListener('DOMContentLoaded', function() {
    cargarDatos();
    setupFormListener();
});

/**
 * Carga el perfil y las habilidades al iniciar
 */
async function cargarDatos() {
    try {
        await cargarPerfil();
        await cargarHabilidades();
    } catch (error) {
        console.error('Error al cargar datos:', error);
        mostrarError('Error al cargar los datos');
    }
}

/**
 * Carga y muestra el perfil
 */
async function cargarPerfil() {
    try {
        const perfil = await obtenerPerfil();
        mostrarPerfil(perfil);
    } catch (error) {
        console.error('Error al cargar perfil:', error);
        document.getElementById('perfil-content').innerHTML = 
            '<p style="color: #ef4444;">No hay perfil disponible.</p>';
    }
}

/**
 * Muestra el perfil en la interfaz
 */
function mostrarPerfil(perfil) {
    const perfilContent = document.getElementById('perfil-content');
    
    if (!perfil) {
        perfilContent.innerHTML = '<p>No hay perfil disponible.</p>';
        return;
    }

    let html = `
        <h3>${perfil.nombre || 'Sin nombre'}</h3>
        <div class="perfil-info">
    `;

    if (perfil.bio) {
        html += `<p><strong>Bio:</strong> ${perfil.bio}</p>`;
    }

    if (perfil.experiencia) {
        html += `<p><strong>Experiencia:</strong> ${perfil.experiencia}</p>`;
    }

    if (perfil.contacto) {
        html += `<p><strong>Contacto:</strong> ${perfil.contacto}</p>`;
    }

    if (perfil.fotoPerfil) {
        html += `<p><strong>Foto de Perfil:</strong> ${perfil.fotoPerfil}</p>`;
    }

    html += '</div>';
    perfilContent.innerHTML = html;
}

/**
 * Carga y muestra las habilidades
 */
async function cargarHabilidades() {
    try {
        const habilidades = await obtenerHabilidades();
        mostrarHabilidades(habilidades);
    } catch (error) {
        console.error('Error al cargar habilidades:', error);
        document.getElementById('habilidades-content').innerHTML = 
            '<p style="color: #ef4444;">Error al cargar las habilidades.</p>';
    }
}

/**
 * Muestra las habilidades en la interfaz
 */
function mostrarHabilidades(habilidades) {
    const habilidadesContent = document.getElementById('habilidades-content');

    if (!habilidades || habilidades.length === 0) {
        habilidadesContent.innerHTML = '<p>No hay habilidades registradas.</p>';
        return;
    }

    let html = '';

    habilidades.forEach(habilidad => {
        const nivelClase = habilidad.nivel.toLowerCase();
        html += `
            <div class="habilidad-card">
                <h4>${habilidad.nombre}</h4>
                <div class="habilidad-info">
                    <p><strong>Nivel:</strong> 
                        <span class="nivel-badge ${nivelClase}">${habilidad.nivel}</span>
                    </p>
                    <p><strong>Experiencia:</strong> ${habilidad.experienciaAnios} años</p>
                    ${habilidad.descripcion ? `<p><strong>Descripción:</strong> ${habilidad.descripcion}</p>` : ''}
                </div>
                <div class="habilidad-actions">
                    <button class="btn btn-secondary btn-small" onclick="editarHabilidad('${habilidad.id}')">
                        Editar
                    </button>
                    <button class="btn btn-danger btn-small" onclick="eliminarHabilidadUI('${habilidad.id}')">
                        Eliminar
                    </button>
                </div>
            </div>
        `;
    });

    habilidadesContent.innerHTML = html;
}

/**
 * Configura el listener del formulario
 */
function setupFormListener() {
    const form = document.getElementById('habilidad-form');
    form.addEventListener('submit', manejarSubmitFormulario);
}

/**
 * Maneja el envío del formulario
 */
async function manejarSubmitFormulario(event) {
    event.preventDefault();

    const nombre = document.getElementById('nombre').value;
    const nivel = document.getElementById('nivel').value;
    const experiencia = parseInt(document.getElementById('experiencia').value);
    const descripcion = document.getElementById('descripcion').value;

    const habilidad = {
        nombre,
        nivel,
        experienciaAnios: experiencia,
        descripcion
    };

    try {
        const resultado = await crearHabilidad(habilidad);
        mostrarExito('Habilidad creada correctamente');
        document.getElementById('habilidad-form').reset();
        await cargarHabilidades();
    } catch (error) {
        console.error('Error al crear habilidad:', error);
        mostrarError('Error al crear la habilidad');
    }
}

/**
 * Edita una habilidad (función placeholder)
 */
function editarHabilidad(id) {
    alert(`Editar habilidad: ${id}`);
    // Implementar lógica de edición
}

/**
 * Elimina una habilidad desde la UI
 */
async function eliminarHabilidadUI(id) {
    if (confirm('¿Estás seguro de que deseas eliminar esta habilidad?')) {
        try {
            const resultado = await eliminarHabilidad(id);
            mostrarExito('Habilidad eliminada correctamente');
            await cargarHabilidades();
        } catch (error) {
            console.error('Error al eliminar habilidad:', error);
            mostrarError('Error al eliminar la habilidad');
        }
    }
}

/**
 * Muestra mensaje de éxito
 */
function mostrarExito(mensaje) {
    mostrarMensaje(mensaje, 'success');
}

/**
 * Muestra mensaje de error
 */
function mostrarError(mensaje) {
    mostrarMensaje(mensaje, 'error');
}

/**
 * Muestra un mensaje temporal
 */
function mostrarMensaje(mensaje, tipo) {
    const alertClass = tipo === 'success' ? 'alert-success' : 'alert-error';
    const alertHTML = `<div class="alert ${alertClass}">${mensaje}</div>`;
    
    // Insertar antes del main
    const main = document.querySelector('main');
    const alertElement = document.createElement('div');
    alertElement.innerHTML = alertHTML;
    main.parentNode.insertBefore(alertElement.firstChild, main);

    // Eliminar después de 5 segundos
    setTimeout(() => {
        const alert = document.querySelector('.alert');
        if (alert) {
            alert.remove();
        }
    }, 5000);
}
