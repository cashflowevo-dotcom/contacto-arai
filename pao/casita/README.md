# Nuestra casita — primera etapa

## Archivos
- `index.html`: acceso, buzón, respuestas, diario y enlace al juego.
- `setup.sql`: tablas y políticas RLS.
- El minijuego existente se conserva en `/pao/gatitos/`.

## Configuración (una vez)
1. Crea un proyecto en https://supabase.com/ (el plan gratuito sirve para comenzar).
2. En Supabase abre **SQL Editor → New query**, pega `setup.sql` y ejecútalo.
3. En **Authentication → Users → Add user**, crea una sola cuenta compartida con el correo y contraseña que ambos usarán. No habilites registro público.
4. En **Project Settings → API** o **Connect**, copia la Project URL y la clave **publishable** (o la antigua anon key). Nunca uses `service_role` o secret key en el frontend.
5. Abre `https://cashflowevo-dotcom.github.io/contacto-arai/pao/casita/`, pega URL y clave y guarda la configuración en el dispositivo. Repite en el otro celular.
6. Inicia sesión con la cuenta compartida. Prueba enviar un mensaje, responder y guardar un recuerdo. En el otro celular, inicia sesión y pulsa Actualizar para confirmar que se comparte.

## Seguridad y límites de esta etapa
- La web está alojada públicamente en GitHub Pages, pero el contenido se almacena en Supabase.
- Las tablas tienen Row Level Security y las políticas solo permiten operaciones a usuarios autenticados.
- Las claves publishable/anon están diseñadas para frontend; nunca pongas una `service_role` o secret key en el HTML.
- Como usan una cuenta compartida, no se puede verificar quién escribió cada registro.
- No guardes contenido real hasta ejecutar el SQL y probar acceso desde una sesión cerrada.
- Aún no hay edición/borrado, archivos adjuntos, notificaciones push ni actualización en tiempo real. El buzón se actualiza al abrirlo o tocar Actualizar.
