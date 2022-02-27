""" Local logging module """
import datetime
import logging


def init(log_file=None, verbose=False):
    """ Initialize logging utility """

    log_format = ('%(asctime)s.%(msecs)03d %(name)-4s '
                  '%(levelname)-4s %(message)s')

    date_format = '%Y-%m-%d %H:%M:%S'
    log_level = logging.DEBUG if verbose else logging.INFO

    # Clear up loggers in case they were created before
    logging.getLogger().handlers.clear()

    if log_file:
        logging.basicConfig(
            filename=datetime.datetime.now().strftime(log_file),
            level=log_level,
            format=log_format,
            datefmt=date_format)
    else:
        logging.basicConfig(
            level=log_level,
            format=log_format,
            datefmt=date_format)

    if verbose:
        logging.info('Verbose logging on.')
