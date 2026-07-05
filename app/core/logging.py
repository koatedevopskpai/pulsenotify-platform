import logging
import sys


def configure_logging(level: str = "INFO") -> None:
    logging.basicConfig(
        format=(
            "%(asctime)s | %(levelname)-8s | %(name)s:%(lineno)d | %(message)s"
            if __debug__
            else '{"time":"%(asctime)s","level":"%(levelname)s","module":"%(name)s","line":%(lineno)d,"msg":"%(message)s"}'
        ),
        level=level.upper(),
        stream=sys.stdout,
    )
