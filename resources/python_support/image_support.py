from PIL import Image
import imagehash

def compare_image(expected_image, avatar): 
    hash0 = imagehash.average_hash(Image.open(expected_image))
    hash1 = imagehash.average_hash(Image.open(avatar))

    if hash0 - hash1 < 1:
        return True
    else:
        return False