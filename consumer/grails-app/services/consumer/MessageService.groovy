package consumer

import grails.transaction.Transactional

@Transactional
class MessageService {

    static rabbitQueue = 'reverse'

    void handleMessage(String message) {
        println "Received Message: ${message}"

        new Message(message: message.reverse()).save()
    }

}