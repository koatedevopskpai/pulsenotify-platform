import logging
import sys


HUMAN_FORMAT = "%(asctime)s | %(levelname)-8s | %(name)s:%(lineno)d | %(message)s"
JSON_FORMAT = (
    '{"time":"%(asctime)s","level":"%(levelname)s",'
    '"module":"%(name)s","line":%(lineno)d,"msg":"%(message)s"}'
)


def configure_logging(level: str = "INFO") -> None:
    logging.basicConfig(
        format=HUMAN_FORMAT if __debug__ else JSON_FORMAT,
        level=level.upper(),
        stream=sys.stdout,
    )
