"""Functions used in preparing Guido's gorgeous lasagna.

Learn about Guido, the creator of the Python language:
https://en.wikipedia.org/wiki/Guido_van_Rossum

This is a module docstring, used to describe the functionality
of a module and its functions and/or classes.
"""

EXPECTED_BAKE_TIME: int = 40
PREPARATION_TIME: int = 2

def bake_time_remaining(elapsed_bake_time: int) -> int:
    """Calculate the bake time remaining.

    :param elapsed_bake_time: int - baking time already elapsed.
    :return: int - remaining bake time (in minutes) derived from 'EXPECTED_BAKE_TIME'.

    Function that takes the actual minutes the lasagna has been in the oven as
    an argument and returns how many minutes the lasagna still needs to bake
    based on the `EXPECTED_BAKE_TIME`.
    """

    return EXPECTED_BAKE_TIME - elapsed_bake_time


def preparation_time_in_minutes(number_of_layers: int) -> int:
    """ Calculate preparation time in minutes

    :param number_of_layers: int - the number of layers added to the lasagna

    Function that takes the number of layers in the lasagna and
      returns how many minutes you would spend making number_of_layers.
    """
    return PREPARATION_TIME * number_of_layers


def elapsed_time_in_minutes(number_of_layers: int, elapsed_bake_time: int) -> int:
    """ Calculate total elapsed cooking time (prep + bake) in minutes

    :param number_of_layers: int - number of layers added to the lasagna
    :param elapsed_bake_time: int - number of minutes the lasagna has been baking

    Function that takes the number of layers in the lasagna and the elapsed time the lasagana
        has been baking, and returns the total number of minutes you have been cooking
    """
    return preparation_time_in_minutes(number_of_layers) + elapsed_bake_time
