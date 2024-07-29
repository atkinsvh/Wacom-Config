import asyncio
import websockets
import json

# WebSocket server parameters
SERVER_IP = 'localhost'  # Replace with the server's IP address if needed
PORT = 8765  # The port used in the server script

async def receive_input():
    async with websockets.connect(f"ws://{SERVER_IP}:{PORT}") as websocket:
        try:
            while True:
                data = await websocket.recv()
                input_data = json.loads(data)
                x, y = input_data['x'], input_data['y']
                print(f"Cursor position: x={x}, y={y}")
        except websockets.ConnectionClosed:
            print("Connection closed")
        except Exception as e:
            print(f"Error: {e}")

if __name__ == "__main__":
    asyncio.run(receive_input())

