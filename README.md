# Custom PyTorch ML block example for Edge Impulse

This repository is an example on how to [bring your own model](https://docs.edgeimpulse.com/docs/adding-custom-transfer-learning-models) into Edge Impulse. This repository contains a small fully-connected model built in PyTorch. If you want to see a more complex PyTorch example, see [edgeimpulse/yolov5](https://github.com/edgeimpulse/yolov5). Or if you're looking for the Keras example, see [edgeimpulse/example-custom-ml-block-keras](https://github.com/edgeimpulse/example-custom-ml-block-keras).

As a primer, read the [Bring your own model](https://docs.edgeimpulse.com/docs/adding-custom-transfer-learning-models) page in the Edge Impulse docs.

## Running the pipeline

You run this pipeline via Docker. This encapsulates all dependencies and packages for you.

### Running via Docker

1. Install [Docker Desktop](https://www.docker.com/products/docker-desktop/).
2. Install the [Edge Impulse CLI](https://docs.edgeimpulse.com/docs/edge-impulse-cli/cli-installation) v1.16.0 or higher.
3. Create a new Edge Impulse project, and add data from the [continuous gestures](https://docs.edgeimpulse.com/docs/continuous-gestures) dataset.
4. Under **Create impulse** add a 'Spectral features' processing block, and a random ML block.
5. Open a command prompt or terminal window.
6. Initialize the block:

    ```
    $ edge-impulse-blocks init
    # Answer the questions, select "other" for 'What type of data does this model operate on?'
    ```

7. Fetch new data via:

    ```
    $ edge-impulse-blocks runner --download-data data/
    ```

8. Build the container:

    ```
    $ docker build -t custom-ml-pytorch .
    ```

9. Run the container to test the script (you don't need to rebuild the container if you make changes):

    ```
    $ docker run --rm -v $PWD:/app custom-ml-pytorch --data-directory /app/data --epochs 30 --learning-rate 0.01 --out-directory out/
    ```

10. This creates two .tflite files and a saved model ZIP file in the 'out' directory.

#### Adding extra dependencies

If you have extra packages that you want to install within the container, add them to `requirements.txt` and rebuild the container.

## Fetching new data

To get up-to-date data from your project:

1. Install the [Edge Impulse CLI](https://docs.edgeimpulse.com/docs/edge-impulse-cli/cli-installation) v1.16 or higher.
2. Open a command prompt or terminal window.
3. Fetch new data via:

    ```
    $ edge-impulse-blocks runner --download-data data/
    ```

## Pushing the block back to Edge Impulse

You can also push this block back to Edge Impulse, that makes it available like any other ML block so you can retrain your model when new data comes in, or deploy the model to device. See [Docs > Adding custom learning blocks](https://docs.edgeimpulse.com/docs/edge-impulse-studio/organizations/adding-custom-transfer-learning-models) for more information.

1. Push the block:

    ```
    $ edge-impulse-blocks push
    ```

2. The block is now available under any of your projects. Depending on the data your block operates on, you can add it via:
    * Object Detection: **Create impulse > Add learning block > Object Detection (Images)**, then select the block via 'Choose a different model' on the 'Object detection' page.
    * Image classification: **Create impulse > Add learning block > Transfer learning (Images)**, then select the block via 'Choose a different model' on the 'Transfer learning' page.
    * Audio classification: **Create impulse > Add learning block > Transfer Learning (Keyword Spotting)**, then select the block via 'Choose a different model' on the 'Transfer learning' page.
    * Other (classification): **Create impulse > Add learning block > Custom classification**, then select the block via 'Choose a different model' on the 'Machine learning' page.
    * Other (regression): **Create impulse > Add learning block > Custom regression**, then select the block via 'Choose a different model' on the 'Regression' page.
