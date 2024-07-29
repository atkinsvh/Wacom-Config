import asyncio
import websockets
import subprocess

clients = set()

async def register(websocket):
    clients.add(websocket)
    try:
        print(f"New client connected: {websocket.remote_address}")
        await websocket.wait_closed()
    finally:
        print(f"Client disconnected: {websocket.remote_address}")
        clients.remove(websocket)

async def screen_stream(websocket, path):
    await register(websocket)

async def relay_stream():
    process = subprocess.Popen(
        ['ffmpeg', '-f', 'mpegts', '-i', 'udp://localhost:12345', '-c', 'copy', '-f', 'mpegts', 'pipe:1'],
        stdout=subprocess.PIPE
    )

    while True:
        frame = process.stdout.read(1024)
        if not frame:
            break
        await asyncio.gather(*[client.send(frame) for client in clients])

async def main():
    port = 8765
    print(f"Server started on ws://localhost:{port}")

    asyncio.create_task(relay_stream())

    async with websockets.serve(screen_stream, "0.0.0.0", port):
        await asyncio.Future()  # Run forever

if __name__ == "__main__":
    asyncio.run(main())
