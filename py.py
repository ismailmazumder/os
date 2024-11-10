from PIL import Image

# Open the image and convert it to 8-bit (palette mode)
img = Image.open("image.png")
img = img.resize((320, 200))  # Resize to fit Mode 13h
img = img.convert("P")  # Convert to 256-color palette mode

# Save raw data
with open("image.raw", "wb") as f:
    f.write(img.tobytes())
