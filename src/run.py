import logging

import apptemp
import apptemp.logging
import apptemp.routes

if __name__ == '__main__':
    apptemp.logging.init(verbose=False)
    logging.info('Starting Flask server...')

    apptemp.app.run()
