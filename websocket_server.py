import asyncio
import websockets

connected_clients = set()

async def handler(websocket, path):
    connected_clients.add(websocket)
    try:
        async for message in websocket:
            await asyncio.wait([client.send(message) for client in connected_clients if client != websocket])
    finally:
        connected_clients.remove(websocket)

start_server = websockets.serve(handler, '0.0.0.0', 8765, ping_interval=None, ping_timeout=None)

asyncio.get_event_loop().run_until_complete(start_server)
asyncio.get_event_loop().run_forever()
