"""Functions to prevent a nuclear meltdown."""

def is_criticality_balanced(
        temperature: int,
        neutrons_emitted: int|float
    ) -> bool:
    """Verify criticality is balanced.

    :param temperature: int or float - temperature value in kelvin.
    :param neutrons_emitted: int or float - number of neutrons emitted per second.
    :return: bool - is criticality balanced?

    A reactor is said to be critical if it satisfies the following conditions:
    - The temperature is less than 800 K.
    - The number of neutrons emitted per second is greater than 500.
    - The product of temperature and neutrons emitted per second is less than 500000.
    """

    return temperature < 800 \
            and neutrons_emitted > 500 \
            and temperature * neutrons_emitted < 500000


def reactor_efficiency(
        voltage: int|float,
        current: int|float,
        theoretical_max_power: int|float
    ) -> str:
    """Assess reactor efficiency zone.

    :param voltage: int or float - voltage value.
    :param current: int or float - current value.
    :param theoretical_max_power: int or float - power that corresponds to a 100% efficiency.
    :return: str - one of ('green', 'orange', 'red', or 'black').

    Efficiency can be grouped into 4 bands:

    1. green -> efficiency of 80% or more,
    2. orange -> efficiency of less than 80% but at least 60%,
    3. red -> efficiency below 60%, but still 30% or more,
    4. black ->  less than 30% efficient.

    The percentage value is calculated as
    (generated power/ theoretical max power)*100
    where generated power = voltage * current
    """

    power = current * voltage
    efficiency = power / theoretical_max_power

    if efficiency >= 0.8:
        result = 'green'
    elif efficiency < 0.8 and efficiency >= 0.6:
        result = 'orange'
    elif efficiency < 0.6 and efficiency >= 0.3:
        result = 'red'
    else:
        result = 'black'

    return result

def fail_safe(
        temperature: int|float,
        neutrons_produced_per_second: int|float,
        threshold: int|float
    ) -> str:
    """Assess and return status code for the reactor.

    :param temperature: int or float - value of the temperature in kelvin.
    :param neutrons_produced_per_second: int or float - neutron flux.
    :param threshold: int or float - threshold for category.
    :return: str - one of ('LOW', 'NORMAL', 'DANGER').

    1. 'LOW' -> `temperature * neutrons per second` < 90% of `threshold`
    2. 'NORMAL' -> `temperature * neutrons per second` +/- 10% of `threshold`
    3. 'DANGER' -> `temperature * neutrons per second` is not in the above-stated ranges
    """

    value = temperature * neutrons_produced_per_second

    if value < 0.9 * threshold:
        result = 'LOW'
    elif value >= 0.9 * threshold and value <= 1.1 * threshold:
        result = 'NORMAL'
    else:
        result = 'DANGER'

    return result