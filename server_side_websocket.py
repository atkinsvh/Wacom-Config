import asyncio
import websockets
import pyautogui
import json

# Function to capture Wacom tablet input (or any other input using pyautogui)
async def capture_input(websocket, path):
    print("Client connected")
    try:
        while True:
            x, y = pyautogui.position()
            data = json.dumps({'x': x, 'y': y})
            await websocket.send(data)
            await asyncio.sleep(0.01)  # Adjust the sleep time as necessary
    except websockets.ConnectionClosed:
        print("Connection closed")
    except Exception as e:
        print(f"Error: {e}")

async def main():
    # Get a random available port
    port = 8765  # You can randomize this or make it a constant
    print(f"Server started on ws://localhost:{port}")

    async with websockets.serve(capture_input, "0.0.0.0", port):
        await asyncio.Future()  # Run forever

if __name__ == "__main__":
    asyncio.run(main())

