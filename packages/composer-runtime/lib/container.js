/*
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

'use strict';

/**
 * A class representing the chaincode container hosting the JavaScript engine.
 * @protected
 * @abstract
 * @memberof module:composer-runtime
 */
class Container {

    /**
     * Get the version of the chaincode container.
     * @abstract
     * @return {string} The version of the chaincode container.
     */
    getVersion() {
        throw new Error('abstract function called');
    }

    /**
     * Get the logging service provided by the chaincode container.
     * @abstract
     * @return {LoggingService} The logging service provided by the chaincode container.
     */
    getLoggingService() {
        throw new Error('abstract function called');
    }

    /**
     * Stop serialization of this object.
     * @return {Object} An empty object.
     */
    toJSON() {
        return {};
    }

}

module.exports = Container;